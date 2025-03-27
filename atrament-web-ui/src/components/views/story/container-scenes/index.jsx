import { h } from 'preact';
import style from './index.module.css';
import { useState, useEffect } from 'preact/hooks';

const getAlign = (v) => {
  const alignments = {
    top: 'start',
    start: 'start',
    middle: 'center',
    bottom: 'end',
    end: 'end'
  };
  return alignments[v] || 'center';
}

//children here are the literal children of the block
const ContainerScenes = ({ children, align }) => {

  let [contents, setcontents] = useState("");
  useEffect(() => {
    if (children){
      console.log("AHHHH")
      setcontents(() => contents = children);
    }
  }), [contents];


  return (
    <div class={[style.container_scenes, 'atrament-container-scene'].join(' ')} style={{'justify-content': getAlign(align)}}>
      {children}
    </div>
  );
};

export default ContainerScenes;
