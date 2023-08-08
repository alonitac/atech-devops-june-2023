# GitHub SSH

Remote repositories are versions of your project that are hosted somewhere (GitHub, GitLab, BitBucket, Gitea, and many more...).

## Push your local repo to Github

You'll work against your GitHub account using SSH.

1. Generate new SSH keys by:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

2. [Add the public key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account). 

3. [Create a repo in GitHub](https://docs.github.com/en/get-started/quickstart/create-a-repo#create-a-repository) (only the **Create a repository**, excluding the **Commit your first change** section).
4. Add the GitHub repo URL as a remote to your local repo. From the local repo directory, execute:

Change `<YOUR_GITHUB_USERNAME>` to your GitHub username, and `<YOUR_GITHUB_REPO_NAME>` to the name you gave to the created github repo.

```bash
git remote add origin git@github.com:<YOUR_GITHUB_USERNAME>/<YOUR_GITHUB_REPO_NAME>.git
```

5. Test the connectivity. Push branch `master` by:

```bash
git push origin maste
```

Make sure the changes are reflected in GitHub. 