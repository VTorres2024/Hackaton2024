import React from "react";
import "/Users/garinelenrique/documentos/React-Voting-Application-main/src/App.css"; // Import the CSS file for styling

const App = (props) => {
    return (
        <div className="connected-container">
            <h1 className="connected-header">You're Connected to MetaMask</h1>
            <div className="connected-info">
                <p className="connected-account">MetaMask Account:</p>
                <p className="connected-account">{props.account}</p>
            </div>
            <div className="connected-info">
                <p className="connected-account">Remaining Time:</p>
                <p className="connected-account">{props.remainingTime}</p>
            </div>
            {props.showButton ? (
                <p className="connected-account">You've already voted</p>
            ) : (
                <div className="vote-section">
                    <input type="number" className="vote-input" placeholder="Enter Candidate Index" value={props.number} onChange={props.handleNumberChange} />
                    <button className="vote-button" onClick={props.voteFunction}>Vote</button>
                </div>
            )}
            <table className="candidates-table">
                <thead>
                    <tr>
                        <th>Index</th>
                        <th>Candidate Name</th>
                        <th>Votes</th>
                    </tr>
                </thead>
                <tbody>
                    {props.candidates.map((candidate, index) => (
                        <tr key={index}>
                            <td>{candidate.index}</td>
                            <td>{candidate.name}</td>
                            <td>{candidate.voteCount}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default App;
