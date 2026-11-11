$(function() {
  // Apply Tailwind CSS styles to plain rendered markdown
  $('.md-content table').addClass('w-full');
  $('.md-content img').addClass('shadow');
  $('.md-content img').addClass('my-4');
});

$(function() {
  var tutorials = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title', 'summary'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: baseurl + '/search.json?q=' + Date.now(), /* remove Date for production caching */
  });

  $('#search-input').on('keyup keypress blur change', function() {
    var clear = $('#search-clear');
    if ($(this).val() === '') {
      clear.hide();
    } else {
      clear.show();
    }
    searchResults();
  });

  $('#search-filter-button').on('change', function() {
    searchResults();
  });

  $('#nav-toggle').on('click', function() {
    var expanded = $(this).attr('aria-expanded') === 'true';
    $(this).attr('aria-expanded', !expanded);
    $('#navbarContent').toggleClass('hidden', expanded);
  });

  $('#search-clear').click(function(){
    $('#search-input').val('');
    $(this).hide();
    searchResults();
  });

  function searchResults() {
    var search = $('#search-input').val();
    if (search === '') {
      filterResults(tutorials.index.datums);
    } else {
      tutorials.search(search, filterResults, filterResults);
    }
  }

  function filterResults(results) {
    var filter = $('#search-filter-button').val();
    var filteredResults = [];
    for (i in results) {
      var result = results[i];
      if (result.level == filter || filter == 'All Categories') {
        filteredResults.push(result);
      }
    }
    showResults(filteredResults);
  }

  function showResults(results) {
    var tutorialList = $('#tutorial-list');
    if(results.length) {
      var result = '';
      $.each(results, function(i, tutorial) {
        result += '<div class="card-container mx-auto w-72">';
        result += '  <a class="card-tut-link" href="' + tutorial.url + '">';
        result += '    <div class="flex h-full flex-col overflow-hidden rounded border border-gray-200 bg-white shadow">';
        result += '      <div class="p-3 text-white" style="background-color: #5F368A">';
        result += '        <div class="card-category">';
        result += '          <small class="title uppercase">' + tutorial.level + '</small>';
        if (tutorial.level == 'Series') {
          result += '            <img src="' + baseurl + '/assets/images/aaflogo.png" class="series float-right"' + ' alt="AAF Series">';
        }
        result += '        </div>';
        result += '        <h5 class="mb-0 text-lg font-semibold">' + tutorial.title + '</h5>';
        result += '      </div>';
        result += '      <div class="flex-1 p-3">';
        result += '        <small class="text-gray-500">' + tutorial.published + '</small>';
        result += '        <p class="py-2">' + tutorial.summary + '</p>';
        result += '      </div>';
        result += '      <div class="border-t border-gray-200 p-3">';
        result += '        <div class="flex justify-between">';
        result += '          <div>';
        result += '            <small class="text-gray-500">Difficulty: </small>';
        result += '            <span class="difficulty-indicator difficulty-indicator-' + tutorial.difficulty + '">';
        result += '              ' + tutorial.difficulty + ' out of 5';
        result += '            </span>';
        result += '          </div>';
        result += '          <div class="text-right">';
        result += '            <small class="text-gray-500">Duration: ' + tutorial.duration + '</small>';
        result += '          </div>';
        result += '        </div>';
        result += '      </div>';
        result += '    </div>';
        result += '  </a>';
        result += '</div>';
      });
      tutorialList.html(result);
    }
    else {
      var noResults = '<div class="card-container mx-auto lg:col-span-10 lg:col-start-2">';
          noResults += '  <div class="rounded bg-white p-4 text-center shadow lg:p-12">';
          noResults += '    <h2 class="my-3">No Matches</h2>';
          noResults += '    <h3 class="mb-4"><small>Can\'t find what you\'re looking for?</small></h3>';
          noResults += '    <p>Make a suggestion or ask our support team for help by submitting a ' +
              ' <a style="padding-bottom: 1px; border-bottom: 1px solid #17a2b8; text-decoration:' +
              ' none;" href="https://aaf.freshdesk.com/support/tickets/new">support ticket</a>.</p>';
          noResults += '  </div>';
          noResults += '</div>';
      tutorialList.html(noResults);
    }
  }

});

$(function() {
  // Check if user has reached the final page of a tutorial
  if($("#tutorial-page").hasClass("last-page")) {
    var completedTutorial;
    if($("#tutorial-page").attr("data-tut-name")) {
      const tutNameAttr = "data-tut-name";
      tutorialLabel = $("#tutorial-page").attr(tutNameAttr);
      storeCompleted(tutorialLabel);
    }
  }
  
  if($(".series-tutorial").length && localStorage.completedTutorials) {
    // If the current page has the .series-tutorial elements 
    // and localStorage.completedTutorials exists, 
    // show completed status
    showCompletedStatus();
  }
});

function storeCompleted(completedTutorial) {
  //console.log(completedTutorial);
  if(localStorage.completedTutorials) {
    //console.log("Has local storage object");
    var completedTutorialsArr = JSON.parse(localStorage.getItem("completedTutorials"));
    
    // Is the completed tutorial label in stored list of completed tutorials?
    if($.inArray(completedTutorial, completedTutorialsArr) == -1) {
      // It's not found so let's update the stored list
      completedTutorialsArr.push(completedTutorial);
      localStorage.completedTutorials = JSON.stringify(completedTutorialsArr);
    }
  } else {
    //console.log("No local storage object");
    var completedTutorialsArr = [completedTutorial];
    localStorage.setItem("completedTutorials", JSON.stringify(completedTutorialsArr));
  }
}

function showCompletedStatus() {
  $(".series-tutorial").each(function() {
    var tutorialLabel = $(this).attr('data-label');
    
    var completedTutorialsArr = JSON.parse(localStorage.getItem("completedTutorials"));
    if($.inArray(tutorialLabel, completedTutorialsArr) != -1) {
      console.log("Completed " + tutorialLabel);
      $(this).addClass("completed");
      $(this).append("<span class='tut-complete'></span>")
    }
  });
}

$(function() {
  $('pre.highlight').attr('tabindex', '0');
});
