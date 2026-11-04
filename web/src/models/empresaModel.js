var database = require("../database/config");

function buscarPorId(idCliente) {
  var instrucaoSql = `SELECT * FROM empresa WHERE idEmpresa = '${idCliente}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT idEmpresa, nome, codigo_ativacao FROM empresa`;

  return database.executar(instrucaoSql);
}

 function buscarPorCnpj(identificacao_fiscal) {
   var instrucaoSql = `SELECT * FROM usuario WHERE identificacao_fiscal = '${identificacao_fiscal}'`;

   return database.executar(instrucaoSql);
 }

function cadastrar(nome) {
  var instrucaoSql = `INSERT INTO empresa (nome) VALUES ('${nome}')`;

  return database.executar(instrucaoSql);
}

module.exports = {buscarPorCnpj, buscarPorId, cadastrar, listar};
