# Directory cleanup action

This action does a SSH into a remote server and cleans up older deployments (directories) with a pre-defined pattern. Preserve only the newest number of configured directories.

Usage:

```
      - name: 'Cleanup old releases'
        uses: eaudeweb/drupal-cleanup-action@1.x
        with:
          ssh_user:             ${{ secrets.TEST_SSH_USER }}
          ssh_host:             ${{ secrets.TEST_SSH_HOST }}
          ssh_key:              ${{ secrets.TEST_SSH_KEY }}
          cleanup_dir:          /var/www/artifacts/example.org
          pattern:              release-*
          retain:               5
```
