import { h } from 'preact';
import style from './index.module.css';
import { useState, useCallback, useEffect } from 'preact/hooks';


const ContainerText = ({ children }) => {
  let [test, setTest] = useState(0);
  const [child_blocks, setChildren] = useState([]);

  useEffect(() => {
    console.log(`component rerendered ${test}`);
  }, [test]);

  return (
    
    <div class={[style.container_text, 'atrament-text-container'].join(' ')}>
      {children}
    </div>
  );
};

export default ContainerText;
