const { NodeProject } = require('projen');
const project = new NodeProject({
  defaultReleaseBranch: 'main',
  name: 'sec-ami',

  // deps: [],                          /* Runtime dependencies of this module. */
  // description: undefined,            /* The description is just a string that helps people understand the purpose of the package. */
  // devDeps: [],                       /* Build dependencies for this module. */
  // packageName: undefined,            /* The "name" in package.json. */
  // projectType: ProjectType.UNKNOWN,  /* Which type of project this is (library/app). */
  // release: undefined,                /* Add release management to this project. */
});

const common_exclude = ['.env', '.docker-build-ami.conf', 'docker-build-ami.log', 'easy-rsa', 'cdk.outputs.json'];
project.npmignore.exclude(...common_exclude);
project.gitignore.exclude(...common_exclude);

project.synth();
