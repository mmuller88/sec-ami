const { AwsCdkTypeScriptApp } = require('projen');
const project = new AwsCdkTypeScriptApp({
  cdkVersion: '1.130.0',
  defaultReleaseBranch: 'main',
  name: 'vpnclient',

  // cdkDependencies: undefined,        /* Which AWS CDK modules (those that start with "@aws-cdk/") this app uses. */
  deps: ['@aws-cdk/aws-ec2'],
  // description: undefined,            /* The description is just a string that helps people understand the purpose of the package. */
  // devDeps: [],                       /* Build dependencies for this module. */
  // packageName: undefined,            /* The "name" in package.json. */
  // projectType: ProjectType.UNKNOWN,  /* Which type of project this is (library/app). */
  // releaseWorkflow: undefined,        /* Define a GitHub workflow for releasing from "main" when new versions are bumped. */
});

project.setScript('cdkDeploy', 'cdk deploy --outputs-file cdk.outputs.json');
project.setScript('cdkDestroy', 'cdk destroy');
project.setScript('cdkSynth', 'cdk synth');
project.setScript('cdk', 'cdk');

project.synth();