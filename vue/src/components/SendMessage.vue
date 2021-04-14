<template>
  <div class="msgcontainer">
    <button class="ninjaButton" v-on:click="catNinja = !catNinja">
      <h3>Send an instant meow-ssage</h3>
    </button>

    <form class="sendMsg" @submit.prevent="sendMsg">
      <label v-show="catNinja" for="sender">Sender Name</label>
      <input
        v-show="catNinja"
        type="text"
        id="sender"
        name="sender"
        v-model="cat.sender"
        placeholder="Sender name.."
      />
      <label v-show="catNinja" for="message">Message</label>
      <textarea
        v-show="catNinja"
        id="message"
        name="message"
        v-model="cat.message"
        placeholder="Type your message here.."
        style="height: 100px"
        required
      ></textarea>
      <div>
        <button
          v-show="catNinja"
          type="submit"
          class="sendMsgButton"
          value="Send Message"
        >
          Send Message
        </button>
      </div>
    </form>
  </div>
</template>


<script>
import catService from "../services/CatService";

export default {
  name: "send-message",
  props: {},

  data() {
    return {
      catNinja: false,
      cat: {
        catId: "",
        sender: "",
        message: "",
      },
    };
  },
  methods: {
    sendMsg() {
      this.cat.catId = this.$store.state.catId;

      catService
        .msgCat(this.cat)
        .then((response) => {
          console.log(response.status);
          if (response.status == "201") {
            this.$router.push("/cats");

            //success
          }
        })
        .catch((error) => {
          // handle an error
          console.log(error.status);
        });
    },
  },
  created() {
    const catId = this.$store.state.catId;

    catService
      .getCatDetails(catId)
      .then((response) => {
        console.log(response);
        console.log(response.data);

        this.catsArray = response.data;
      })
      .catch((error) => {
        console.log(error.statusMsg);
      });
  },
};
</script>

<style scoped>
/* * {
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: center;
} */

input[type="text"],
select,
textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
  margin-top: 6px;
  margin-bottom: 16px;
  resize: vertical;
}

::placeholder {
  color: black;
}
button[type="submit"] {
  background-color: #163da1;
  color: white;
  padding: 12px 20px;
  border: 2px solid #163da1;
  border-radius: 2em;
  cursor: pointer;
  width: 10em;
  outline: 0;
}
button[type="submit"]:active {
  transform: scale(0.98);
  /* Scaling button to 0.98 to its original size */
  box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
  /* Lowering the shadow */
}
button[type="submit"]:hover {
  background-color: #f6faf6;
  color: #163da1;
}
.msgcontainer{
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.sendMsg {
  display: flex;
  flex-direction: column;
  border-radius: 5px;
  color: #163da1;
  padding: 20px;
  font-family: monospace;
  width: 25em;
  margin: 0 auto;
  background: transparent;
  align-items: center;
}

.ninjaButton {
  border-radius: 3em;
  border: 3px solid #163da1;
  background: transparent;
  outline: 0;
}
.ninjaButton:active {
  transform: scale(0.98);
  /* Scaling button to 0.98 to its original size */
  box-shadow: 3px 2px 22px 1px rgba(0, 0, 0, 0.24);
  /* Lowering the shadow */
  background: transparent;
}
</style>