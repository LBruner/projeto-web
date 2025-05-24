// tailwind.config.js
module.exports = {
    content: ["./web/**/*.jsp/*.html/*.jsp"], // 👈 this line is crucial!
    theme: {
        extend: {
            colors:{
                navbar: '#fffefe',
            }
        },
    },
    plugins: [],
}
