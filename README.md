## Development  
***

Developers should be working on macOS. If this doesn't describe you, modify the below accordingly.

### Prerequisites
Install [Jekyll](https://jekyllrb.com/docs/installation/macos). Since Jekyll is a Ruby gem, it relies on the installation of
- Homebrew
- Ruby
- Ruby version manager (such as rbenv or chruby)

The Jekyll docs have detailed instructions on how to install all of these development tools along with Jekyll.

### Setup
1. Open a terminal
2. Clone this project: `git clone git@github.com:ausaccessfed/dev-portal.git`
3. `cd dev-portal`
4. Navigate to the publishing source of the site: `cd docs`
5. Run `bundle install`

### Running the Site locally

1. Build and preview: `bundle exec jekyll serve`
2. To preview your site, in your web browser, navigate to http://localhost:4000.
