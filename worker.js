export default {
    async fetch(request, env) {
        // ASSETS binding is injected automatically by Wrangler
        return env.ASSETS.fetch(request);
    }
}