import { h } from 'preact';
import { useState, useEffect, useMemo } from 'preact/hooks';
import style from 'src/components/ui/container-text/index.module.css';
import { useAtramentState, useAtrament } from 'src/atrament/hooks';

import ContainerText from 'src/components/ui/container-text';
import ContainerScenes from './container-scenes';
import ContainerChoices from './container-choices';
import ContainerImage from 'src/components/ui/container-image';


import Scene from './scene';
import Choices from './choices';
import ChoiceButtonGroup from './choice-button-group';


const StoryView = () => {
  const atramentState = useAtramentState(['scenes', 'metadata']);
  const { getAssetPath, getInkVariable, setInkVariable } = useAtrament();
  const [ isReady, setReady ] = useState(false);
  
  const latestSceneIndex = atramentState.scenes.length - 1;
  const lastSceneIndex = (latestSceneIndex <= 1) ? latestSceneIndex: latestSceneIndex - 1;
  const isHypertextMode = !!atramentState.metadata.hypertext;
  const key = `choices-${atramentState.scenes[latestSceneIndex]?.uuid}`;
  const latestScene = atramentState.scenes[latestSceneIndex];

  // let img = atramentState.scenes[latestSceneIndex].images[0];

  // if (!img)
  //   img = getInkVariable("SetImage");
  // else
  //   setInkVariable("SetImage", img);

  const [image, setImage] = useState("");
  let [history, setHistory] = useState("");
  const [scene, showSceneData] = useState([]);

  useMemo(() => {
    const next = atramentState.scenes[latestSceneIndex].images[0]
    if (image != next)
    {
      console.log(`changing image from ${image} to ${next}`)
      
      setImage(((!next) ? image : next));
    }
    else
      console.log("there is no change")
  });

  useEffect(() => {
    // const scene = atramentState.scenes[latestSceneIndex]
    // setHistory(() => history += scene.content)

    let temp = (scene.length <= 0) ? [] : scene;
    let add = temp.includes(atramentState.scenes[latestSceneIndex])
    
    if (!add)
    {
      temp.push(atramentState.scenes[latestSceneIndex])
    }

    showSceneData(temp)
  });

  return (
    <div class={[style.container_text, 'atrament-text-container'].join(' ')}>
  <ChoiceButtonGroup
        key={key}
        currentScene={scene[latestSceneIndex]}
        setReady={setReady}
      />

      {/* <ContainerScenes align={atramentState.metadata.scenes_align}>
        <ContainerImage key={`${lastSceneIndex}-${image}`} src={getAssetPath(image)} />
      </ContainerScenes>

      <ContainerScenes align={atramentState.metadata.scenes_align}>
          <Scene
            key={`scene-${latestScene.uuid}`}
            scene={latestScene}
            isCurrent={true}
            isSingle={latestSceneIndex === 0}
            readyHandler={setReady} />
      </ContainerScenes> */}
      {/* <Choices
          key={key}
          currentScene={scene[latestSceneIndex]}
          setReady={setReady}
          isHypertextMode={isHypertextMode}
        /> */}
      {/* <ContainerChoices isReady={true} key={key}>
        
      </ContainerChoices> */}
    </div>
  )
}

export default StoryView;
