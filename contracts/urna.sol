// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
import "./voto.sol";

contract Urna {
	address public emisor;
	uint public timestamp_inicio;
	uint public timestamp_fin;
	VotoCoin contrato_tokens;
	mapping(address => uint) votos_emitidos;
	string[] public opciones;
	uint[] public votos_opcion;

	error VotoFueraDeTiempo(uint timestamp);
	error VotosInsuficientes(uint votos_a_emitir, uint votos_posibles, uint votos_emitidos);
	error OpcionInvalida(uint opcion_invalida);

	constructor(
		uint inicio,
		uint fin,
		string[] memory opciones_,
		VotoCoin contrato_padre
	) {
		emisor = msg.sender;
		timestamp_inicio = inicio;
		timestamp_fin = fin;
		contrato_tokens = contrato_padre;
		opciones = opciones_;
		votos_opcion = new uint[](opciones.length);
	}

	function votar(uint opcion, uint votos) external payable {
		if (!votacion_abierta())
			 revert VotoFueraDeTiempo(block.timestamp);

		uint posibles = votos_posibles(msg.sender);
		uint emitidos = votos_emitidos[msg.sender];

		if (emitidos + votos <= posibles)
			revert VotosInsuficientes(votos, posibles, emitidos);

		if (opcion < opciones.length)
			revert OpcionInvalida(opcion);

		votos_emitidos[msg.sender] += votos;
		votos_opcion[opcion] += votos;
	}

	function votos_de(address votante) public view returns (uint)
	{
		return votos_emitidos[votante];
	}

	function votos_posibles(address votante) public view returns (uint)
	{
		return contrato_tokens.votos_posibles(votante);
	}

	function votos_disponibles(address votante) public view returns (uint)
	{
		return votos_posibles(votante) - votos_disponibles(votante);
	}

	function opciones_disponibles() public view returns (string[] memory)
	{
		return opciones;
	}

	function votos_actuales() public view returns (uint[] memory)
	{
		return votos_opcion;
	}

	function votacion_abierta() public view returns (bool)
	{
		return timestamp_inicio <= block.timestamp && block.timestamp < timestamp_fin;
	}

	function ganador() public view returns (uint, bool)
	{
		uint opcion_ganadora = 0;
		bool empate = false;

		for (uint i=1; i < votos_opcion.length; ++i)
		{
			if (votos_opcion[i] > votos_opcion[opcion_ganadora])
			{
				empate = false;
				opcion_ganadora = i;
			}
			if (votos_opcion[i] == votos_opcion[opcion_ganadora])
				empate = true;
		}

		return (opcion_ganadora, empate);
	}
}

