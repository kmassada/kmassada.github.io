# kmassada.github.io

Instructions to manage and maintain this personal blog using Jekyll and
Podman.

**Note:** This guide uses `podman` and `podman-compose`. Commands can be
interchanged with `docker` and `docker-compose`.

## Container Setup

### 1. Build Container Images

From the repository root:

```bash
# Build base dependencies image
podman build -t kmassada.github.io.dep --target dep .

# Build application image
podman build -t kmassada.github.io --target app .
```

### 2. Run Local Development Server

Run the container mounting the workspace root:

```bash
podman run --rm -it -p 4000:4000 -v "$PWD":/usr/src/app:z -w /usr/src/app kmassada.github.io bundle exec jekyll serve -H 0.0.0.0 --incremental --watch --drafts
```

Open [http://localhost:4000](http://localhost:4000) in your browser.

*(Optional)* Using Podman Compose:

```bash
podman compose up -d
```

## Upgrading the Theme

Upgrades refresh the core `minimal-mistakes` theme files directly from upstream
and re-apply local customizations on a temporary `jekyll-upgrade` branch.

### 1. Create a Fresh Upgrade Branch

Always start from an up-to-date `master` branch:

```bash
git checkout master
git pull origin master

# Create or reset the dedicated temporary upgrade branch
git checkout -B jekyll-upgrade master
```

### 2. Fetch Upstream and Refresh Core Theme Files

Ensure the upstream remote is configured:

```bash
# Set up upstream remote (one-time setup)
git remote add upstream https://github.com/mmistakes/minimal-mistakes.git 2>/dev/null || true
git fetch upstream
```

Replace core theme directories with the latest files from upstream:

```bash
# Checkout theme files directly from upstream/master
git checkout upstream/master -- _includes _layouts _sass assets/js assets/css
```

### 3. Restore Local Customizations

Restore your site-specific overrides and configs from `master`:

```bash
git checkout master -- \
  _sass/minimal-mistakes/_custom.scss \
  _sass/minimal-mistakes.scss \
  _data/navigation.yml \
  _data/ui-text.yml \
  _includes/footer.html \
  assets/images/ \
  _config.yml
```

### 4. Update Dependencies

Update `Gemfile.lock` using the container's Ruby environment:

```bash
podman run --rm -v "$PWD":/usr/src/app:z -w /usr/src/app kmassada.github.io.dep bundle update
```

### 5. Verify Locally

Clear the build cache and verify that the site renders properly:

```bash
rm -rf _site .jekyll-metadata .sass-cache

# Run server and inspect http://localhost:4000
podman run --rm -it -p 4000:4000 -v "$PWD":/usr/src/app:z -w /usr/src/app kmassada.github.io bundle exec jekyll serve -H 0.0.0.0 --incremental --watch --drafts
```

**Verification Checklist:**

* `_sass/minimal-mistakes.scss`: Verify `@import "minimal-mistakes/custom";` is
  present.
* `_sass/minimal-mistakes/_custom.scss`: Verify custom styles, icon greying, and
  typography rules are intact.
* `_config.yml`: Verify author profile, social links, and analytics settings.

### 6. Commit and Merge to Master

Once verified, commit the upgrade, merge it into `master`, and delete the
temporary branch:

```bash
git add .
git commit -m "chore: upgrade minimal-mistakes theme"

git checkout master
git merge jekyll-upgrade
git branch -d jekyll-upgrade

# Push changes to origin
git push origin master
```
