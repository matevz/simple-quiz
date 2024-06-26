import { expect } from "chai";
import { ethers } from "hardhat";
import {Quiz, Quiz__factory} from "../typechain-types";
import {getDefaultProvider, JsonRpcProvider, toBigInt} from "ethers";

describe("Quiz", function () {
  async function deployQuiz() {
    const Quiz_factory = await ethers.getContractFactory("Quiz");
    const quiz = await Quiz_factory.deploy();
    await quiz.waitForDeployment();
    return { quiz };
  }

  async function addQuestions(quiz: Quiz) {
    await quiz.addQuestion("The Bitcoin whitepaper was published in 2008.", true);
    await quiz.addQuestion("The expected block time in the Oasis Network is 12 seconds.", false);
    await quiz.addQuestion("The Ethereum whitepaper was published in 2012.", false);
  }

  it("User should get questions", async function () {
    const {quiz} = await deployQuiz();
    await addQuestions(quiz);

    const userQuiz = quiz.connect((await ethers.getSigners())[1]);
    expect(await userQuiz.getQuestions()).to.have.lengthOf(3);
  });

  it("User should check answers", async function () {
    const {quiz} = await deployQuiz();
    await addQuestions(quiz);

    // All answers correct.
    expect(await quiz.checkAnswers([true, false, false])).to.deep.equal([true, true, true]);

    // First answer incorrect.
    expect(await quiz.checkAnswers([false, false, false])).to.deep.equal([false, true, true]);
  });
});
