# Playground

Welcome to my playground! This repository includes miscellaneous code that I've written solely for fun. As I add to this repository, I'll do my best to include an explanation of what I've experimented with for each experiment.

### Ganymede

I wanted to learn more about servers in Ruby, so implemented a simple one myself (which I've named "Ganymede", after the mythical cup-bearer of Zeus). This server follows the Rack specification and is based on an internal tutorial at my last company. The server uses pre-forking where each child process calls `accept` to handle multiple incoming requests.
