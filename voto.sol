// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;
// vim: ts=4

contract VotoCoin 
{
	address public emisor;
	mapping (address => uint) public votos;
	address[] public urnas;

	event Sent(address from, address to, uint amount);

	constructor() 
	{
		emisor = msg.sender;
	}

	function otorgar_votos(address[] calldata nuevos_votantes, uint[] calldata n_votos) public {
		require(msg.sender == emisor);
		require(nuevos_votantes.length == n_votos.length);

		for (uint i=0; i < nuevos_votantes.length; ++i)
			votos[nuevos_votantes[i]] = n_votos[i];
	}

	function remover_votante(address votante) public {
		require(msg.sender == emisor);
		votos[votante] = 0;
	}

	function votos_posibles(address votante) public view returns (uint) {
		return votos[votante];
	}
}
