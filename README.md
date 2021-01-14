# Problem

Input:
```bash
docker build .
```

Output:
```
[INFO] Building jar: /opt/app/target/example-quarkus-csimple-bug-1.0.0-SNAPSHOT.jar
[INFO] 
[INFO] --- quarkus-maven-plugin:1.10.5.Final:build (default) @ example-quarkus-csimple-bug ---
[INFO] [org.jboss.threads] JBoss Threads version 3.1.1.Final
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:20 min
[INFO] Finished at: 2021-01-14T07:25:55Z
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal io.quarkus:quarkus-maven-plugin:1.10.5.Final:build (default) on project example-quarkus-csimple-bug: Failed to build quarkus application: io.quarkus.builder.BuildException: Build failure: Build failed due to errors
[ERROR]         [error]: Build step org.apache.camel.quarkus.core.deployment.CSimpleRouteDefinitionProcessor#configureCSimpleLanguage threw an exception: java.lang.NoClassDefFoundError: org/apache/camel/language/csimple/CSimpleLanguage
[ERROR]         at org.apache.camel.quarkus.core.deployment.CSimpleRouteDefinitionProcessor.configureCSimpleLanguage(CSimpleRouteDefinitionProcessor.java:254)
[ERROR]         at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
[ERROR]         at java.base/jdk.internal.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:62)
[ERROR]         at java.base/jdk.internal.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
[ERROR]         at java.base/java.lang.reflect.Method.invoke(Method.java:566)
[ERROR]         at io.quarkus.deployment.ExtensionLoader$2.execute(ExtensionLoader.java:972)
[ERROR]         at io.quarkus.builder.BuildContext.run(BuildContext.java:277)
[ERROR]         at org.jboss.threads.ContextClassLoaderSavingRunnable.run(ContextClassLoaderSavingRunnable.java:35)
[ERROR]         at org.jboss.threads.EnhancedQueueExecutor.safeRun(EnhancedQueueExecutor.java:2046)
[ERROR]         at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.doRunTask(EnhancedQueueExecutor.java:1578)
[ERROR]         at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1452)
[ERROR]         at java.base/java.lang.Thread.run(Thread.java:834)
[ERROR]         at org.jboss.threads.JBossThread.run(JBossThread.java:479)
[ERROR] Caused by: java.lang.ClassNotFoundException: org.apache.camel.language.csimple.CSimpleLanguage
[ERROR]         at org.codehaus.plexus.classworlds.strategy.SelfFirstStrategy.loadClass(SelfFirstStrategy.java:50)
[ERROR]         at org.codehaus.plexus.classworlds.realm.ClassRealm.unsynchronizedLoadClass(ClassRealm.java:271)
[ERROR]         at org.codehaus.plexus.classworlds.realm.ClassRealm.loadClass(ClassRealm.java:247)
[ERROR]         at org.codehaus.plexus.classworlds.realm.ClassRealm.loadClass(ClassRealm.java:239)
[ERROR]         at io.quarkus.bootstrap.classloading.QuarkusClassLoader.loadClass(QuarkusClassLoader.java:412)
[ERROR]         at io.quarkus.bootstrap.classloading.QuarkusClassLoader.loadClass(QuarkusClassLoader.java:365)
[ERROR]         ... 13 more
[ERROR] -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
The command '/bin/sh -c mvn package -DskipTests' returned a non-zero code: 1
```

# Solution

By [https://github.com/jamesnetherton](@jamesnetherton)

```
Try importing camel-quarkus-bom before the quarkus-platform-bom in dependencyManagement like:

 <dependencyManagement>
    <dependencies>
      <dependency>
          <groupId>org.apache.camel.quarkus</groupId>
          <artifactId>camel-quarkus-bom</artifactId>
          <version>${quarkus.camel.version}</version>
          <type>pom</type>
          <scope>import</scope>
      </dependency>
      <dependency>
        <groupId>${quarkus.platform.group-id}</groupId>
        <artifactId>${quarkus.platform.artifact-id}</artifactId>
        <version>${quarkus.platform.version}</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
  </dependencyManagement>
```
