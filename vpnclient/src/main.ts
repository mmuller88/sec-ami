import * as core from '@aws-cdk/core';
import * as ec2 from '@aws-cdk/aws-ec2';

export class VpnClientStack extends core.Stack {
  constructor(scope: core.Construct, id: string, props: core.StackProps = {}) {
    super(scope, id, props);


    const vpc = new ec2.Vpc(this, 'Vpc', { maxAzs: 1 });
    const sg = new ec2.SecurityGroup(this, 'sg', {
      vpc,
    });
    sg;
    // sg.addIngressRule() all
    const client = new ec2.ClientVpnEndpoint(this, 'clientVpnEndpoint', {
      vpc,
      cidr: '10.10.0.0/22',
      clientCertificateArn: 'arn:aws:acm:eu-central-1:429736546496:certificate/7bbb7fcc-8cda-4633-8d92-ed58e1a47bd6',
      serverCertificateArn: 'arn:aws:acm:eu-central-1:429736546496:certificate/7bbb7fcc-8cda-4633-8d92-ed58e1a47bd6',
      splitTunnel: true,
      authorizeAllUsersToVpcCidr: true,
    });
    client;

    new core.CfnOutput(this, 'subnet', {
      value: vpc.publicSubnets[0].subnetId,
    });

    new core.CfnOutput(this, 'sgOut', {
      value: vpc.vpcDefaultSecurityGroup
    });

    // client.addAuthorizationRule('auth', {
    //   cidr: '0.0.0.0/0'
    // })
  }
}

// for development, use account/region from cdk cli
const buildEnv = {
  account: '981237193288',
  region: 'us-east-1',
};

const app = new core.App();

new VpnClientStack(app, 'vpn-client-stack-dev', { env: buildEnv });

app.synth();