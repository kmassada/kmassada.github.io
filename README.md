# ABOUT

These are the instructions to manage my personal/learning blog using Jekyll.

**Note:** This guide uses `podman` and `podman-compose`. We can simply substitute `podman` with `docker` and `podman-compose` with `docker-compose` in the commands below.

## Containerize

From repo root:

```bash
podman build -t kmassada.github.io.dep --target dep .
podman build -t kmassada.github.io --target app .
podman run --rm -it -p 4000:4000 -v "$PWD":/usr/src/app -w /usr/src/app kmassada.github.io bash
```

From inside the container:

```bash
export JEKYLL_ENV=development
bundle exec jekyll serve -H 0.0.0.0 --incremental --watch --drafts
```

## Podman Compose

Using compose simplifies runtime.

Only run build once, `kmassada.github.io.dep` does not preserve state of container properly, and will build everytime.

```bash
podman compose up -d --build
```

Generally once build has ran once, `-d` will do for restarting/starting compose:

```bash
podman compose up -d
```

## Upgrading

Updating the site involves refreshing the core theme files from the upstream repository and updating the Ruby gems.

### Reset Core Files

This strategy resets the core files to match the latest upstream `minimal-mistakes` state while keeping the git history intact. We will then re-apply the customizations.

```bash
# Ensure upstream is set
git remote add upstream https://github.com/mmistakes/minimal-mistakes.git
git fetch upstream

# Create a fresh branch for the upgrade
git checkout -b jekyll-upgrade

# Merge upstream changes using 'ours' strategy.
# This tells Git: "Record a merge, but keep my files exactly as they are for now."
git merge -s ours upstream/master

# Pull the latest content from upstream.
# This forces the files to match the upstream repository, effectively "resetting" them.
# We will likely need to resolve conflicts here.
git pull upstream master

# Re-apply the customizations (see the "mods" list below)
```

### Update Dependencies

To ensure the `Gemfile.lock` is updated correctly for the container environment, run the update command using the base image.

```bash
# Update the lockfile on the host using the container's ruby environment
podman run --rm -v "$PWD":/usr/src/app -w /usr/src/app kmassada.github.io.dep bundle update

# Rebuild the application image to include the updated gems
podman compose build
```

### Verify and Merge

Test the site locally to ensure the upgrade didn't break anything.

```bash
# Start the site
podman compose up

# If everything looks good, merge the changes back to master
git checkout master
git merge jekyll-upgrade
git branch -d jekyll-upgrade
git push origin master
```

## Customizations (Mods)

After the merge, the custom files may be overwritten or reset. `git checkout` can restore the specific customizations from the `master` branch.

```bash
# Example: Restore the custom configurations and assets from the master branch
git checkout master -- \
  _sass/minimal-mistakes/_custom.scss \
  _sass/minimal-mistakes.scss \
  _data/navigation.yml \
  _data/ui-text.yml \
  includes/footer.html \
  assets/images/ \
  _config.yml
```

**Checklist:**
*   `_sass/minimal-mistakes.scss`: Verify `@import "minimal-mistakes/custom";` is present.
*   `_sass/_custom.scss`: Verify has our preferred customizations required.
*   `_config.yml`: Ensure site title, author, and gem versions are correct.
