var database = require("../database/config");

function buscarPorId(idCliente) {
  var instrucaoSql = `SELECT * FROM cliente WHERE idCliente = '${idCliente}'`;

  return database.executar(instrucaoSql);
}

function listar() {
  var instrucaoSql = `SELECT idCliente, nome, identificacao_fiscal, codigo_ativacao FROM cliente`;

  return database.executar(instrucaoSql);
}

function buscarPorCnpj(identificacao_fiscal) {
  var instrucaoSql = `SELECT * FROM cliente WHERE identificacao_fiscal = '${identificacao_fiscal}'`;

  return database.executar(instrucaoSql);
}

function cadastrar(nome, identificacao_fiscal) {
  var instrucaoSql = `INSERT INTO cliente (nome, identificacao_fiscal) VALUES ('${nome}', '${identificacao_fiscal}')`;

  return database.executar(instrucaoSql);
}

module.exports = {buscarPorCnpj, buscarPorId, cadastrar, listar};
