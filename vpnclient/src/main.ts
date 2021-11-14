import * as core from '@aws-cdk/core';
import * as ec2 from '@aws-cdk/aws-ec2';

export interface VpnClientStackProps extends core.StackProps {
  certArn: string;
}
export class VpnClientStack extends core.Stack {
  constructor(scope: core.Construct, id: string, props: VpnClientStackProps) {
    super(scope, id, props);

    const vpc = new ec2.Vpc(this, 'Vpc', { maxAzs: 1 });
    const sg = new ec2.SecurityGroup(this, 'sg', {
      vpc,
    });
    sg.addIngressRule(ec2.Peer.anyIpv4(), ec2.Port.allTraffic());

    const client = new ec2.ClientVpnEndpoint(this, 'clientVpnEndpoint', {
      vpc,
      securityGroups: [sg],
      cidr: '10.10.0.0/22',
      clientCertificateArn: props.certArn,
      serverCertificateArn: props.certArn,
      splitTunnel: true,
      authorizeAllUsersToVpcCidr: true,
    });
    client;

    new core.CfnOutput(this, 'subnet', {
      value: vpc.privateSubnets[0].subnetId,
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

new VpnClientStack(app, 'vpn-client-stack-dev', {
  env: buildEnv,
  certArn: 'arn:aws:acm:us-east-1:981237193288:certificate/10a8404f-9bc4-444b-bcd6-096d5ae0e71f',
});

app.synth();