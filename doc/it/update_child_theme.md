# It/Update Child Theme

This is a runbook that defines the steps necessary to update the Wordpress Hueman 7L child theme to match Hueman upstream.
Child Theme is found at: https://github.com/ecovillage/hueman-7l-child
Hueman Theme Upstream is found at https://github.com/presscustomizr/hueman
You might need to adjust the path definitions in this file in order to work with it.
git rebase would come to the rescue, but for that, it seems to be too late and also because we are dealing with diffs (child theme) its yet unclear how this would work smoothly.

## 1. Find out branches and versions

1. [] Find out which version the current child is based off.

   within: ~/projects/7l/fk/hueman-7l-child/

   capture: `cat HUEMAN_BASE_VERSION` into base_version

2. [] Find version of upstream Hueman theme.

   within: ~/projects/7l/fk/hueman-repo/hueman/

   capture: `git tag --list 'v*' --sort="version:refname" | tail -n 1` into upstream_version

3. [] Smile if nothing has to be done

   run:
   ```ruby
   ruby_command do
     if @base_version == @upstream_version
       notice "Nothing to do, exit now!"
     else
       notice "Child is based on: #{@base_version}"
       notice "Upstream hueman is: #{@upstream_version}"
     end
   end
   ```

## 2. 'Rebase' changes of upstream into child theme

1. [] Find base files of files in child

2. [] Find upstream changes

3. [] Integrate upstream changes

4. [] Update child themes HUEMAN_BASE_VERSION

5. [] Tag and push a new child theme version

6. [] Update parent theme in wordpress

7. [] Update child theme in wordpress

