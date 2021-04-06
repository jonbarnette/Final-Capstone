<template>
  <div>
    <div id="searchHomes">
        <label for="zip">Enter Your Zip Code To FInd Your Next Dream Home:</label>
        <input type="text" name="zip" v-model="zipFilter"/>
    </div>      
    <div id="main-div">
      <div class="divTable minimalistBlack" v-show="filteredHomes.length > 0">
        <div class="divTableHeading">
          <div class="divTableRow">
            <div class="divTableHead"></div>
            <div class="divTableHead">MLS Id</div>
            <div class="divTableHead">Address</div>
            <div class="divTableHead">Description</div>
            <div class="divTableHead">Price</div>
          </div>
        </div>
        <div class="divTableBody">
          <div class="divTableRow" v-for="home in filteredHomes" v-bind:key="home.mlsNumber">
            <div class="divTableCell">
                  <img v-bind:src="getImageURL(home.imageName)" />

            </div>
            <div class="divTableCell">{{ home.mlsNumber }}</div>
            <div class="divTableCell">
               <p>{{ home.address.addressLine }} </p>
               <p>{{ home.address.city }}, {{ home.address.state }} {{ home.address.zipCode}}  </p>
            </div>
            <div class="divTableCell">{{ home.description }}</div>
            <div class="divTableCell">{{ home.price }}</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import homeService from '../services/HomeService.js';

export default {
  name: "home-search",
  data() {
    return {
       zipFilter: '',
       homes: [],
    };
  },
  computed: {
     filteredHomes() {
         return this.homes.filter((home) => {  
              console.log(this.zipFilter);
             return this.zipFilter === '' ? true : this.zipFilter == home.address.zipCode;
         });
     }
  },
  created() {
    homeService.search().then(response => {
      this.homes = response.data;
    });
  },
  methods: {
    getImageURL(pic) {
      return require('../assets/' + pic);
    }
  }
  

}

</script>

<style scoped>

img {
    width: 200px;
    height: auto;
}

#main-div {
    margin: 30px;
}
#searchHomes {
    margin: 30px;
}

input[type=text] {
    margin: 30px;
    width: 10%;
    padding: 12px 14px;
    border: 2px solid green;
    border-radius: 6px;
}

div.minimalistBlack {
  margin: auto;
  border: 2px solid #06b712;
  width: 80%;
  text-align: left;
  border-collapse: collapse;
}
.divTable.minimalistBlack .divTableCell,
.divTable.minimalistBlack .divTableHead {
  border: 1px solid #000000;
  padding: 4px 4px;
  justify-content: center;
  vertical-align: middle;
}
.divTable.minimalistBlack .divTableBody .divTableCell {
  font-size: 14px;
}
.divTable.minimalistBlack .divTableHeading {
  background: #1dff2c;
  background: -moz-linear-gradient(top, #55ff61 0%, #33ff41 66%, #1dff2c 100%);
  background: -webkit-linear-gradient(
    top,
    #55ff61 0%,
    #33ff41 66%,
    #1dff2c 100%
  );
  background: linear-gradient(to bottom, #55ff61 0%, #33ff41 66%, #1dff2c 100%);
  border-bottom: 3px solid #0f9a39;
}
.divTable.minimalistBlack .divTableHeading .divTableHead {
  font-size: 15px;
  font-weight: bold;
  color: #109902;
  text-align: left;
}
.minimalistBlack .tableFootStyle {
  font-size: 14px;
}
/* DivTable.com */
.divTable {
  display: table;
  table-layout: fixed;
}
.divTableRow {
  display: table-row;
}
.divTableHeading {
  display: table-header-group;
}
.divTableCell,
.divTableHead {
  display: table-cell;
}
.divTableHeading {
  display: table-header-group;
}
.divTableFoot {
  display: table-footer-group;
}
.divTableBody {
  display: table-row-group;
}

.status-message {
  display: block;
  border-radius: 5px;
  font-weight: bold;
  font-size: 1rem;
  text-align: center;
  padding: 10px;
  margin-bottom: 10px;
}
.status-message.success {
  background-color: #90ee90;
}
.status-message.error {
  background-color: #f08080;
}
</style>