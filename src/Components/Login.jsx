import React from "react";

const Login = (props) => {
    return (
        <div className="login-container">
            <h1 className="welcome-message">bienvenido <div/>a<div/> web3vote</h1>
            <button className="login-button" onClick = {props.connectWallet}>Entrar con MetaMask</button>
        </div>
    )
}

export default Login;