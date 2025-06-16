// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

/**
 * @title KipuBanco
 * @author Alexey Romero
 */

contract KipuBanco {
    uint256 public immutable limiteRetiroPorTransaccion;
    uint256 public immutable limiteDeposito;
    mapping(address => uint256) private saldosUsuarios;
    uint256 public depositosRealizadosGlobales;
    uint256 public retirosRealizadosGlobales;

    event DepositoExitoso(address indexed usuario, uint256 monto);
    event RetiroExitoso(address indexed usuario, uint256 monto);

    constructor(uint256 _limiteDeposito, uint256 _limiteRetiroPorTransaccion) {
        limiteDeposito = _limiteDeposito;
        limiteRetiroPorTransaccion = _limiteRetiroPorTransaccion;
    }

    modifier verificarMontoMayorACero(uint256 _monto) {
        require(_monto > 0, "El monto debe ser mayor a cero");
        _;
    }

    modifier verificarLimiteDeposito() {
        require(address(this).balance <= limiteDeposito, "El monto de deposito excede el limite");
        _;
    }

    modifier verificarlimiteRetiro(uint256 _monto) {
        require(_monto <= limiteRetiroPorTransaccion, "El monto de retiro excede el limite");
        _;
    }

    modifier verificarSaldoSuficiente(uint256 _monto) {
        require(saldosUsuarios[msg.sender] >= _monto, "Saldo insuficiente");
        _;
    }

    function depositar()
        external
        payable
        verificarLimiteDeposito
    {
        require(msg.value > 0, "El monto del deposito debe ser mayor a cero");

        _actualizarBalance(msg.sender, msg.value, true);

        emit DepositoExitoso(msg.sender, msg.value);
    }

    function retirar(uint256 _monto)
        external
        verificarMontoMayorACero(_monto)
        verificarlimiteRetiro(_monto)
        verificarSaldoSuficiente(_monto)
    {
        _actualizarBalance(msg.sender, _monto, false);

        (bool exito, ) = payable(msg.sender).call{value: _monto}("");
        require(exito, "La transferencia fallo");

        emit RetiroExitoso(msg.sender, _monto);
    }
    
    function obtenerMiSaldo() external view returns (uint256) {
        return saldosUsuarios[msg.sender];
    }

    function obtenerSaldoTotalBanco() external view returns (uint256) {
        return address(this).balance;
    }

    function _actualizarBalance(address _usuario, uint256 _monto, bool _esDeposito) private {
        if (_esDeposito) {
            saldosUsuarios[_usuario] += _monto;
            depositosRealizadosGlobales++;
        } else {
            saldosUsuarios[_usuario] -= _monto;
            retirosRealizadosGlobales++;
        }
    }
}