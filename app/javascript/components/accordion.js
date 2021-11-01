import React from 'react';

class accordion extends React.Component{
  constructor(  ){
    super();
    state={
      windowOpen: false
    }
  }

  windowOpen(){
    const accordion = true
  }


  render(){
    return(
      <div>
        <button onClick={this.windowOpen}>ボタン</button>
      </div>
    )
  }
}

export default accordion

