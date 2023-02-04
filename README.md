# What is it?

A docker container to build and use the `docsis` utility to compile DOCSIS
cablemodems configuration files into binary files.

Based on `/raalger/docsis`.


# Usage

## Build the image

    docker build -t docsis .

which will produce the image `docsis:latest`.

Tech notes:

* the binary is located at `/usr/local/bin/docsis`
* a builder image is first created, then the binary is copied over to a slim
  Alpine Linux image without the overhead of the build environment
* `ENTRYPOINT` is directly set to run the `docsis` tool without arguments
* doesn't use any network ports or volumes; bind-mount dirs with `-v` instead
* example cfg files are included in the image at `/usr/local/share/docsis`


## Run the tool

To show the help screen, simply run with no arguments:

    docker run --rm -t docsis

Suppose your config file is located in `/tmp` on the host and you want to
produce the corresponding binary configuration file for the cablemodem:

    docker run --rm -t -v /tmp:/tmp docsis -e /tmp/my.cfg /tmp/my.key /tmp/output.cm


## Use a shell instead

To execute a shell with this image instead, launch it like this:

    docker run --rm -ti -v /tmp:/tmp --entrypoint /bin/sh docsis
