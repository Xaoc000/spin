import subprocess
import os

def cmd(cmd_str):
    """Execute shell commands"""
    ret = subprocess.call(cmd_str.split())
    if ret != 0:
        raise Exception('Command failed: ' + cmd_str)

def str2bool(v):
  if isinstance(v, bool):
      return v
  return v.lower() in ("yes", "true")

def up(**kwargs):
    if 'help' in kwargs:
        print 'Default arguments:'
        print '--bootstrap=false'
        return

    os.environ['KUBECONFIG'] = 'conf/kube.conf'

    # Default args
    args = {}
    args['bootstrap'] = False

    # Parse input args
    for key, val in kwargs.items():
        args[key] = str2bool(val)

    if args['bootstrap']:
        cmd('./plugins/boulder/script/bootstrap.bash')

    cmd('kubectl apply -f plugins/boulder/boulder.yml')

def down():
    os.environ['KUBECONFIG'] = 'conf/kube.conf'
    cmd('kubectl delete -f plugins/boulder/boulder.yml')

def test():
    os.environ['KUBECONFIG'] = 'conf/kube.conf'
    cmd('plugins/boulder/script/test.bash')

def describe():
    os.environ['KUBECONFIG'] = 'conf/kube.conf'
    cmd('kubectl get pods -n iofog')
    cmd('kubectl describe pods -l app=boulder-demo -n iofog')