# This is all based on conventional commits guidelines: https://www.conventionalcommits.org/en/about/ https://www.conventionalcommits.org/
#

# Enforcing Conventional Commits with a Git Hook

# This gist provides instructions on how to set up a `commit-msg` 
# Git hook to enforce [conventional commits](http://www.conventionalcommits.org) in your project. 
# The `commit-msg` script checks the commit message against a regex pattern to ensure 
# it follows the conventional commit format. 
# The `text-styles.sh` script is used to colorize the output of the `commit-msg` script for better readability.

# ----- 1. Copy the hook files to .git/hooks -----
# You need to copy the files from <root>/hooks into <root>/.git/hooks when initializing your project.
# You can do this by adding this [pre script](https://docs.npmjs.com/cli/v9/using-npm/scripts#pre--post-scripts) 
# to your package.json file

{
  "name": "your-package",
  "version": "1.0.0",
  "scripts": {
    "prestart": "chmod +x hooks/* && mkdir -p .git/hooks && cp hooks/* .git/hooks/ && chmod +x .git/hooks/*",
    "start": "your-start-command"
  }
}

# ---- 2. Create a file <root>/hooks/commit-msg (no extention) ----

#!/usr/bin/env sh
echo "Running commit message checks..."

. "$(dirname -- "$0")/text-styles.sh"


# Get the commit message
commit="$(cat .git/COMMIT_EDITMSG)"
# Define the conventional commit regex
regex="^(build|chore|ci|docs|feat|fix|perf|refactor|revert|style|test)(\(.+\))?: .+$"


# Check if the commit message matches the conventional commit format
if ! echo "$commit" | grep -Pq "$regex"
then
    echo
    colorPrint red "❌ Failed to create commit. Your commit message does not follow the conventional commit format."
    colorPrint red "Please use the following format: $(colorPrint brightRed 'type(scope)?: description')"
    colorPrint red "Available types are listed below. Scope is optional. Use ! after type to indicate breaking change."
    echo
    colorPrint brightWhite "Quick examples:"
    echo "feat: add email notifications on new direct messages"
    echo "feat(shopping cart): add the amazing button"
    echo "feat!: remove ticket list endpoint"
    echo "fix(api): handle empty message in request body"
    echo "chore(deps): bump some-package-name to version 2.0.0"
    echo
    colorPrint brightWhite "Commit types:"
    colorPrint brightCyan "build: $(colorPrint white "Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)" -n)"
    colorPrint brightCyan "ci: $(colorPrint white "Changes to CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)" -n)"
    colorPrint brightCyan "chore: $(colorPrint white "Changes which doesn't change source code or tests e.g. changes to the build process, auxiliary tools, libraries" -n)"
    colorPrint brightCyan "docs: $(colorPrint white "Documentation only changes" -n)"
    colorPrint brightCyan "feat: $(colorPrint white "A new feature" -n)"
    colorPrint brightCyan "fix: $(colorPrint white "A bug fix" -n)"
    colorPrint brightCyan "perf: $(colorPrint white "A code change that improves performance" -n)"
    colorPrint brightCyan "refactor: $(colorPrint white "A code change that neither fixes a bug nor adds a feature" -n)"
    colorPrint brightCyan "revert: $(colorPrint white "Revert a change previously introduced" -n)"
    colorPrint brightCyan "test: $(colorPrint white "Adding missing tests or correcting existing tests" -n)"
    echo

    colorPrint brightWhite "Reminders"
    echo "Put newline before extended commit body"
    echo "More details at $(underline "http://www.conventionalcommits.org")"
    echo
    exit 1
fi

# ---- 2. Create a file <root>/hooks/text-styles.sh (to have access to pretty colourfull logging) ----

!/usr/bin/env sh

colorPrint() {
  local color=$1
  local text=$2
  shift 2
  local newline="\n"
  local tab=""

  for arg in "$@"
  do
    if [ "$arg" = "-t" ]; then
      tab="\t"
    elif [ "$arg" = "-n" ]; then
      newline=""
    fi
  done

  case $color in
    black) color_code="30" ;;
    red) color_code="31" ;;
    green) color_code="32" ;;
    yellow) color_code="33" ;;
    blue) color_code="34" ;;
    magenta) color_code="35" ;;
    cyan) color_code="36" ;;
    white) color_code="37" ;;
    brightBlack) color_code="90" ;;
    brightRed) color_code="91" ;;
    brightGreen) color_code="92" ;;
    brightYellow) color_code="93" ;;
    brightBlue) color_code="94" ;;
    brightMagenta) color_code="95" ;;
    brightCyan) color_code="96" ;;
    brightWhite) color_code="97" ;;
    *) echo "Invalid color"; return ;;
  esac

  printf "\e[${color_code}m${tab}%s\e[0m${newline}" "$text"
}

underline () {
  printf "\033[4m%s\033[24m" "$1"
}
