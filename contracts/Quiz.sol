// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A simple yes/no on-chain quiz.
contract Quiz {
    string constant errNotAllowed = "Not allowed";
    string constant errWrongNumberOfAnswers = "Wrong number of answers";

    struct QuizQuestion {
        // Question/Statement.
        string question;
    }

    // Owner of the contract.
    address _owner;
    // List of questions.
    QuizQuestion[] _questions;
    // Is the question/statement correct or not.
    bool[] _correct;

    modifier onlyOwner {
        require(msg.sender == _owner, errNotAllowed);
        _;
    }

    constructor() payable {
        _owner = msg.sender;
    }

    // Adds an new question/statement and if it is correct or not.
    function addQuestion(string memory question, bool correct) external onlyOwner {
        _questions.push(QuizQuestion(question));
        _correct.push(correct);
    }

    // Removes all questions/statements.
    function clearQuestions() external onlyOwner {
        delete _questions;
        delete _correct;
    }

    // Updates the existing question/statement.
    function setQuestion(uint questionIndex, string memory question, bool correct) external onlyOwner {
        _questions[questionIndex] = QuizQuestion(question);
        _correct[questionIndex] = correct;
    }

    // Returns correct answers to all questions/statements.
    function getCorrectAnswers() private view returns (bool[] memory) {
        return _correct;
    }

    // Fetches the questions.
    function getQuestions() external view returns (QuizQuestion[] memory) {
        return _questions;
    }

    // Checks provided answers and returns which answers were correct.
    function checkAnswers(bool[] memory answers) external view returns (bool[] memory) {
        require(answers.length == _questions.length, errWrongNumberOfAnswers);

        bool[] memory correctVector = new bool[](_questions.length);
        for (uint i=0; i< _correct.length; i++) {
            bool answerCorrect = (_correct[i]==answers[i]);
            correctVector[i] = answerCorrect;
        }
        return correctVector;
    }
}
