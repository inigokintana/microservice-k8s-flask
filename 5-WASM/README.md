python3 -m http.server 8000

With pygbag pygame is loaded but not urllib3, httpx or request

With Pyodide pygame sinot loaded see index.tml in 5-WASM 


Pyodade request support
https://github.com/koxudaxi/datamodel-code-generator/issues/1957

See worker libraries done by Clouddflare
https://blog.cloudflare.com/python-workers/#async-client-libraries
https://developers.cloudflare.com/workers/languages/python/how-python-workers-work/

See https://wasmer.io/

Docker WASM - K8s https://www.docker.com/blog/docker-wasm-technical-preview/

WASI

###
https://www.reddit.com/r/WebAssembly/comments/1akf2vw/newbie_can_wasm_run_without_browser_or_is_it_tied/

Yes, absolutely wasm can run outside the browser - I would sketch a few major use cases:

Inside of a Browser - Chrome/V8, Safari, Firefox/Spider Monkey)

Server Side Wasm - using a runtime and often a distribution like wasmtime inside of CNCF wasmCloud or CNCF wasmEdge

Embedded - Typically out Linux, running on a microcontroller - WAMR seems to be the most popular engine here.

There are a ton more projects and distributions, the CNCF has a great landscape, but I would comment that only a couple of these are actually CNCF projects (wasmCloud & wasmEdge):

https://landscape.cncf.io/?group=wasm&view-mode=grid

What is neat about Wasm is that it is actually standardized under the W3C and while Wasm modules have been around for a while the most recent standard is around an idea called WebAssembly Components - think of them as lego blocks for code.

https://www.infoworld.com/article/3689875/building-the-component-model-for-wasm.html
Hopefully this get's you started.

BTW - I work on CNCF wasmCloud! - come join our slack, slack.wasmCloud.com, lots of helpful folks there!
###