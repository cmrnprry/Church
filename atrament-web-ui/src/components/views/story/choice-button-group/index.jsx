import { h } from 'preact';
import { useState, useCallback, useEffect } from 'preact/hooks';
import { useAtrament } from 'src/atrament/hooks';
import ChoiceButton from '../choice-button';

const ChoiceButtonGroup = ({ key, currentScene, setReady }) => {
  const { makeChoice, continueStory, fadeOutScene } = useAtrament();
  const [ chosen, setChosen ] = useState(null);

  const numberOfChoices = (currentScene && currentScene.choices) ? currentScene.choices.length : -1;

  const selectChoice = useCallback((id) => {
    const delay = numberOfChoices > 1 ? 3500 : 1500;
    setChosen(id);
    setTimeout(() => {
      // pass choice to Atrament
      fadeOutScene();
      setTimeout(() => {
        setChosen(null);
        setReady(false);
        makeChoice(id);
        continueStory();
      }, delay);
    }, 0);
  }, [ makeChoice, continueStory, setReady, numberOfChoices, fadeOutScene ]);

  const kbdChoiceHandler = useCallback((e) => {
    const kbdChoice = +e.key;
    const targetElement = e.target.tagName.toLowerCase();
    if (targetElement === 'input') {
      // ignore keyboard event
      return; 
    }
    if (
      numberOfChoices > 0 &&
      kbdChoice > 0 &&
      kbdChoice <= numberOfChoices &&
      !currentScene.choices[kbdChoice-1].disabled
    ) {
      selectChoice(currentScene.choices[kbdChoice-1].id);
    }
  }, [ numberOfChoices, selectChoice, currentScene.choices ]);

  useEffect(() => {
    document.addEventListener("keydown", kbdChoiceHandler, false);
    setReady(true)
    return () => {
      document.removeEventListener("keydown", kbdChoiceHandler, false);
    }
  }, [ kbdChoiceHandler ]);

  return (
    <>
      {currentScene.choices.filter((choice) => choice.choice.includes("+") == false).map((choice, index) => (
        <ChoiceButton
          key={`${key}-${index}`}
          choice={choice}
          chosen={chosen}
          handleClick={selectChoice}
        />))
      }
    </>
  ) 
};

export default ChoiceButtonGroup;
