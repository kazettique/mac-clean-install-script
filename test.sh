# testing use

# source func.sh
# source app-list.sh

# for app in "${macStoreApps[@]}"; do
#     echo "$app"
# done
# echo "${brewCaskList[@]}"

defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FK_DefaultListViewSettings -dict \
  calculateAllSizes -bool true \
  iconSize -int 16 \
  sortColumn -string "dateAdded" \
  textSize -int 16 \
  useRelativeDates -bool false