# Vite Vue Starter 
### (with GCP GKE workflow)

This is a project template using [Vite](https://vitejs.dev/). It requires [Node.js](https://nodejs.org) v12+.

To start:

```sh
npm install
npm run dev

# if using yarn:
yarn
yarn dev
```

### Workflow
- Git push takes the code to `github.com`
- Google `Cloud Build` builds with the new code and creates a `release`
- Google `Cloud Deploy` deploys the new release using a configured pipeline to the configured target and ups the GKE cluster
