# Building

1. build the "cross image" locally (used to build cross-platform static go binaries)
   1. `cd $PROJECT_ROOT/scripts/cross`
   1. `docker build -t vault-cross .`
1. create release distribution(s) of vault (set to only build `linux/amd64`)
   1. `cd $PROJECT_ROOT/scripts`
   1. `./local-dist.sh [version]`
      * supply a version such as `1.1.0_01`
1. build the final vault docker image
   1. `cd $PROJECT_ROOT/docker`
   1. `./build.sh [version]`
      * supply the same version as the dist above, such as `1.1.0_01`
