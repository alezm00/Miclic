import os, shutil, sys, subprocess, time, psutil
workSpacePath = sys.argv[1]
version = open(f"{workSpacePath}/version","r").read().replace("\n","")
releasesPath = os.path.join(workSpacePath,"Releases")
from config import *


for proc in psutil.process_iter():
    # check whether the process name matches
    if proc.name() == "arma3server_x64.exe":
        print("Kill arma3server_x64.exe")
        proc.kill()
    if proc.name() == "arma3_x64.exe":
        print("Kill arma3_x64.exe")
        proc.kill()
time.sleep(5)


mod = os.path.join(workSpacePath,modName)




print("Building mod...")
print('version:', version)
time.sleep(2)




releaseVersionFolder = os.path.join(releasesPath,version)

if os.path.isdir(releaseVersionFolder):
    shutil.rmtree(releaseVersionFolder)

#create release version
os.mkdir(releaseVersionFolder)
os.mkdir(os.path.join(releaseVersionFolder,modName))


#copy mod from dev to version
shutil.copytree(mod,os.path.join(releaseVersionFolder,modName), dirs_exist_ok=True)
shutil.copy(os.path.join(workSpacePath,"version"),os.path.join(releaseVersionFolder,modName))



#build MOD
includes = os.path.join(workSpacePath,addonBuilder_IncludesPath)
def build(toBuild):
    #build MOD
    subprocess.run([
        addonBuilder,
        os.path.join(releaseVersionFolder,modName,'Addons',toBuild),
        os.path.join(releaseVersionFolder,modName,'Addons'),
        "-clear",
        "-packonly",
        f"-sign={privateKEY}",
        f"-include={includes}",
    ])

    shutil.rmtree(os.path.join(releaseVersionFolder,modName,'Addons',toBuild))


for i in BUILD_LIST:
    build(i)
    print(f"Build {i} DONE")


print("Build complete")

def signMod(toSign):
    subprocess.run([
        DSSignFile,
        privateKEY,
        os.path.join(releaseVersionFolder,modName,'Addons',toSign)
    ])

for i in SIGN_LIST:
    signMod(i)
    print(f"Sign {i} DONE")


print("Sign complete")


time.sleep(2)



print("ZIP release")
#zip for release
shutil.make_archive(os.path.join(releaseVersionFolder,f"{modName}_{version}"), 'zip', os.path.join(releaseVersionFolder,modName))


print("New LATEST")
#copy last build to latest
latest = os.path.join(releasesPath,'Latest',modName)
shutil.rmtree(os.path.join(releaseVersionFolder,latest))
shutil.copytree(os.path.join(releaseVersionFolder,modName),latest)
