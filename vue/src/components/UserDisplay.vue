<template>
  <!-- <div class="background">

  <div>
   <img class="catimage"

   src="../Assets/CatUsers/3000.jpg"
   
   />


  </div>
  
  </div> -->
<div>
    <div id="searchUsers">
        <label for="occupation">Enter occupation:</label>
        <input type="text" name="occupation" v-model="occupationFilter" />
            
    </div>
<div id="main-div">
      <div class="divTable minimalistBlack" v-show="filteredCats.length > 0">
        <div class="divTableHeading">
          <div class="divTableRow">
            <div class="divTableHead"></div>
            <div class="divTableHead">Name</div>
            <div class="divTableHead">Age</div>
            <div class="divTableHead">Occupation</div>
            <div class="divTableHead">Description</div>
          
          </div>
        </div>
        <div class="divTableBody">
          <div class="divTableRow" v-for="cat in filteredCats" v-bind:key="cat.name">
            <div class="divTableCell">
                <img v-bind:src="cat.imageName" />
            </div>
            <div class="divTableCell">{{ cat.name }}</div>
            <div class="divTableCell">{{ cat.age }}</div>
            <div class="divTableCell">{{ cat.occupation }}</div>
            <div class="divTableCell">{{ cat.description }}</div>
           
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
export default {

  name: "user-display",
  props: ["user"],
data() {
    return {
      occupationFilter: "",
    };
  },
  computed: {
    filteredCats() {
      const filteredCats = this.$store.state.catlist;
      console.log(filteredCats);
      return filteredCats.filter((cat) => {
        return this.occupationFilter === ""
          ? true
          : this.occupationFilter === cat.occupation;
      });
    },
  },

};


</script>



<style>
.catimage {
  display: block;
  margin-left: auto;
  margin-right: auto;
  height: 50em;
  width: auto;
}
.background {
  background-color: #16ffbd;
}
</style>