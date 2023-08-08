# GitHub SSH

Remote repositories are versions of your project that are hosted somewhere (GitHub, GitLab, BitBucket, Gitea, and many more...).

## Add SSH keys to your GitHub account

You'll work against your GitHub account using SSH.

Generate new SSH keys by:

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

[Add the public key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account). 
