// w przykładzie jest zapis dla starszego systemu modułów JavaScript - CommonJS, więc korekta z: 
// module.exports = (srv) => {
// na zapis dla oficjalnego standardu JavaScript (od ES6) - ES Module, który i tak jest zdefiniowany w package.json ("type": "module"):
export default (srv) => {

    // Reply mock data for Books...
    srv.on('READ', 'Books', () => [
        { ID:201, title:'Aaa', author_ID:150, stock:120 },
        { ID:211, title:'Bbb', author_ID:120, stock:230 },
        { ID:221, title:'Ccc', author_ID:150, stock:15 },
        { ID:231, title:'Dcc', author_ID:170, stock:140 },
    ])

    // Reply mock data for Authors...
    srv.on('READ', 'Authors', () => [
        { ID:120, name:'Krzysiek Adamski' },
        { ID:150, name:'Adam Adamski' },
        { ID:170, name:'Monika Adamska' },
    ])

}
