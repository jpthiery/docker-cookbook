import hudson.model.*;
import jenkins.model.*;

try {
    def j = Jenkins.instance;
    def p = j.pluginManager;
    def uc = j.updateCenter;
    
    p.doCheckUpdatesServer();
    ['docker-plugin', 'delivery-pipeline-plugin', 'build-pipeline-plugin', 'git'].each { n ->
      j.updateCenter.getById('default').getPlugin(n).deploy(false).get();
    }
    
    p.doCheckUpdatesServer();
    
    System.exit(0);
} catch (Throwable t) {
    t.printStackTrace();
    System.exit(1);
}