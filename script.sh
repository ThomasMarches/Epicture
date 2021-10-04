RED='\033[1;31m'
GREEN='\033[0;32m'
NC='\033[0m'

printf "${GREEN}[${RED}ANALYZING REPOSITORY${NC}${GREEN}]${NC}\n\n"

flutter analyze lib test

printf "\n${GREEN}[${RED}FORMATTING REPOSITORY${NC}${GREEN}]${NC}\n\n"

flutter format --set-exit-if-changed lib test

printf "\n${GREEN}[${RED}TESTING REPOSITORY${NC}${GREEN}]${NC}\n\n"

flutter test --no-pub --coverage --test-randomize-ordering-seed random

printf "\n${GREEN}[${RED}DONE${NC}${GREEN}]${NC}\n\n"
