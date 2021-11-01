import React from 'react';
import Modal from 'react-modal';
import axios from "axios";
import { faWindowClose } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";


const customStyles = {
  content : {
    top                   : '50%',
    left                  : '50%',
    right                 : 'auto',
    bottom                : 'auto',
    marginRight           : '-50%',
    transform             : 'translate(-50%, -50%)'
 }
};

Modal.setAppElement('.friend-request-boxs') //任意のアプリを設定する　create-react-appなら#root
class ModalWindow extends React.Component {
  constructor() {
    super();
    this.state = {
      modalIsOpen: false
    };
    this.openModal = this.openModal.bind(this);
    this.afterOpenModal = this.afterOpenModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.friendSubmit=this.friendSubmit.bind(this);
  }
  openModal() {
    this.setState({modalIsOpen: true});
  }
  afterOpenModal() {
    //this.subtitle.style.color = '#f00';
  }
  closeModal() {
    this.setState({modalIsOpen: false});
  }
  friendSubmit(){
   axios.patch("http://localhost:3000/friends/"+`${this.props.friend.id}`,{"request":1, "id":`${this.props.friend.id}`})
   .then(response => console.log(response))
   .catch(response => console.log(response))
   this.setState({modalIsOpen: false})
  }

  render() {
    return (
      <div>
        <button onClick={this.openModal}>友達承認画面</button>
        <Modal
          isOpen={this.state.modalIsOpen}
          onAfterOpen={this.afterOpenModal}
          onRequestClose={this.closeModal}
          style={customStyles}
          contentLabel="Example Modal"
        >
          <h2 ref={subtitle => this.subtitle = subtitle}>友達リクエスト</h2>
          <div className="modal-section">
            {this.props.from_user.nickname}
          </div>
          <div className="modal-section">
            <FontAwesomeIcon icon={faWindowClose} onClick={this.closeModal} />
          </div>
          <img className="modal-avatar" src={this.props.from_user.avatar.url} height="200px" width="200px"/>
          <div>
            {this.props.from_user.text}
          </div>
            <button onClick={this.friendSubmit}>友達の承認</button>
            <button onClick={this.closeModal}>リクエスト拒否</button>
        </Modal>
      </div>
    );
  }
}
export default ModalWindow;