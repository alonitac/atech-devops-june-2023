import json
import requests

GITHUB_TOKEN_FILE = '.githubtoken'
REPO_URL = 'https://api.github.com/repos/alonitac/atech-devops-june-2023'

with open(GITHUB_TOKEN_FILE) as f:
    t = f.read()


def fetch_success_workflows():
    project_results = []
    res = {'total_count': float('inf')}
    page = 1

    while len(project_results) < res['total_count']:
        res = requests.get(f'{REPO_URL}/actions/runs',
                           params={
                               "page": page,
                               "status": "success",
                               "per_page": "100"
                           },
                           headers={
                               "Accept": "application/vnd.github+json",
                               "Authorization": f"Bearer {t}",
                               "X-GitHub-Api-Version": "2022-11-28"
                           })

        res = res.json()
        page += 1
        project_results += res['workflow_runs']


    data = [d for d in project_results if d['conclusion'] == 'success']
    branches = sorted(set([d['head_branch'] for d in data]))
    return [print(b) for b in branches]



if __name__ == '__main__':
    fetch_success_workflows()

