import hudson.model.*;
import jenkins.model.*;

try {
    println "Install docker pluging"
    def j = Jenkins.instance;
    def p = j.pluginManager;
    def uc = j.updateCenter;
    
    p.doCheckUpdatesServer();
    ['docker-plugin'].each { n ->
      j.updateCenter.getById('default').getPlugin(n).deploy(false).get();
    }
    
    p.doCheckUpdatesServer();
    
    System.exit(0);
} catch (Throwable t) {
    t.printStackTrace();
    System.exit(1);
}