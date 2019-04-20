import subprocess
import os

def cmd(cmd_str):
    """Execute shell commands"""
    ret = subprocess.call(cmd_str.split())
    if ret != 0:
        raise Exception('Command failed: ' + cmd_str)

def up(bootstrap):
    os.environ['KUBECONFIG'] = 'conf/kube.conf'
    if bootstrap:
        cmd('source plugins/boulder/script/add_to_catalog.bash')
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