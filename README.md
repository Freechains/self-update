# Self-update
This repository has two scripts that auto-update Freechains

The first script "self-update-first.sh" is responsable for creating a host and join the chain in which each update will be posted. The second script "self-update.sh" is responsable for running the programa that de facto updates freechains.

To run the first script:
<code>
./self-update-first.sh <1> <2> <3>
</code>

To run the second script:
<code>
sudo ./self-update.sh <1> <2> <3>
</code>

Legend:

1 - Path to create directory

2 - Machine's IP

3 - The gateway
