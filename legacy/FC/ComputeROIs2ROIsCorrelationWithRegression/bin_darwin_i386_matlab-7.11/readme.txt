MATLAB Compiler

1. Prerequisites for Deployment 

. Verify the MATLAB Compiler Runtime (MCR) is installed and ensure you    
  have installed version 7.14.   

. If the MCR is not installed, run MCRInstaller, located in:

  <mcr_root>*/toolbox/compiler/deploy/maci64/MCRInstaller.dmg

For more information on the MCR Installer, see the MATLAB Compiler 
documentation.    



2. Files to Deploy and Package

Files to package for Standalone 
================================
-run_ComputeROIs2ROIsCorrelationWithRegression.sh (shell script run to temporarily set 
 environment variables and execute the application)
   -to run the shell script, type
   
       ./run_ComputeROIs2ROIsCorrelationWithRegression.sh <mcr_directory> <argument_list>
       
    at Unix or Mac command prompt. <mcr_directory> is the directory 
    where version 7.14 of MCR is installed or the directory where 
    MATLAB is installed on the machine. <argument_list> is all the 
    arguments you want to pass to your application. For example, 

    If you have version 7.14 of MCR installed in 
    /mathworks/home/application/R2010a/v714, run the shell script as:
    
       ./run_ComputeROIs2ROIsCorrelationWithRegression.sh /mathworks/home/application/R2010a/v714
       
    If you have MATLAB installed in /mathworks/devel/application/matlab, 
    run the shell script as:
    
       ./run_ComputeROIs2ROIsCorrelationWithRegression.sh /mathworks/devel/application/matlab
-MCRInstaller.dmg 
   -include when building component by selecting "include MCR" option 
    in deploytool
-The Macintosh bundle directory structure ComputeROIs2ROIsCorrelationWithRegression.app 
   -this can be gathered up using the zip command 
    zip -r ComputeROIs2ROIsCorrelationWithRegression.zip ComputeROIs2ROIsCorrelationWithRegression.app
    or the tar command 
    tar -cvf ComputeROIs2ROIsCorrelationWithRegression.tar ComputeROIs2ROIsCorrelationWithRegression.app
-This readme file 

3. Definitions

MCR - MATLAB Compiler uses the MATLAB Compiler Runtime (MCR), 
which is a standalone set of shared libraries that enable the execution 
of M-files. The MCR provides complete support for all features of 
MATLAB without the MATLAB GUI. When you package and distribute an 
application to users, you include supporting files generated by the 
builder as well as the MATLAB Compiler Runtime (MCR). If necessary, 
run MCRInstaller to install version 7.14 of MCR. For more 
information about the MCR, see the MATLAB Compiler documentation.




* NOTE: <mcr_root> is the directory where MCR is installed on the target machine.


4. Appendix 

A. On the target machine, add the MCR directory to the system path    
   specified by the target system's environment variable. 


    i. Locate the name of the environment variable to set, using the  
       table below:

    Operating System        Environment Variable
    ================        ====================
    Mac                     DYLD_LIBRARY_PATH


     ii. Set the path by doing one of the following:

        NOTE: <mcr_root> is the directory where MCR is installed
              on the target machine.         


        . Add the MCR directory to the environment variable by issuing 
          the following commands:

            setenv DYLD_LIBRARY_PATH
                <mcr_root>/v714/runtime/maci64:
                <mcr_root>/v714/sys/os/maci64:
                <mcr_root>/v714/bin/maci64:
                /System/Library/Frameworks/JavaVM.framework/JavaVM:
                /System/Library/Frameworks/JavaVM.framework/Libraries
            setenv XAPPLRESDIR <mcr_root>/v714/X11/app-defaults


        NOTE: To make these changes persistent after logout on UNIX or 
              Mac machines, modify the .cshrc file to include this  
              setenv command.
        NOTE: on UNIX or Mac, the environment variable syntax utilizes   
              forward slashes (/), delimited by colons (:).  
        NOTE: When deploying standalone applications, it is possible 
              to run the shell script file run_ComputeROIs2ROIsCorrelationWithRegression.sh 
              on UNIX and Mac instead of setting environment variables. 
              See section 2 "Files to Deploy and Package".    

5. Launching of application using Macintosh finder.

If the application is purely graphical, that is, it doesn't read from standard in or 
write to standard out or standard error, it may be launched in the finder just like any 
other Macintosh application.
