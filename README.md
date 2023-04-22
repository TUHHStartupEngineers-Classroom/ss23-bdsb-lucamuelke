# Lab Journal website using quarto

This quarto website template  for lab journaling. Students in the data science courses at the Institute of Entrepreneurship will use this template to learn R for business analytics. 

To use this, click the download as .zip button to start from a local computer, or skip down to the github example to fork this and get started that way.

The unzipped folder contains all of the files you need to compile a website in quarto. This should all work fine if you have the latest version of R and R-studio installed.

Once your content is on GitHub, you can easily host it as a GitHub Pages website. This is a service where GitHub hosts your static files as if they were a standalone website.

[https://tuhhstartupengineers.github.io/quarto_journal_template/](https://tuhhstartupengineers.github.io/quarto_journal_template/)

pw: `test` 

Click `Remember me` if you do not want to enter it every time.

## Steps for compiling on your local computer

1. Make sure R and R-studio (and quarto. comes with the newest version of RStudio) are installed
2. Navigate to the folder you just downloaded, open the 'lab_journal.RProj' file. This should automatically open R-studio, and your current working environment will be inside this project. That means everything you save will be auto saved to this folder (unless you tell R-studio to save something somewhere else.
3. Inside R-studio you should see a files tab in the bottom right hand corner. Most files you click will be opened up as text files in the R-studio editor. Click the "Index.qmd" file.
4. To compile the entire website, find the build tab in the top right hand corner. You should see the option to "render website". Click this. The website should be built.
5. After the website is built, you should be able to see it in the R-studio browser. There is a little button (blue arrow with a little browser icon) that allows you to pop the website into your default web-browser. This way you can look at the website in your browser. 

Important: After compilation, all of the files for displaying your website are saved in the folder where your R project resides. When you look at these in a browser (for example, by going to the folder and dragging the index.html file into a browser), you are loading from your disk. Only you will be able to see the website, because it is on your hard-drive. You need to upload to a web server to serve the webpage on the internet.

## Steps for serving your webpage using github pages.

This is the source code repository for making the webpage in R-studio. At the same time, the resulting website is being served from this repository at this link [https://tuhhstartupengineers.github.io/quarto_journal_template/](https://tuhhstartupengineers.github.io/quarto_journal_template/).

Every github repository has the capability of serving html files (web page files) contained in the repository, this is called github pages. How this works depends a little bit on the specific repository you are using. For this repository the webpage is built in the _site folder and served from the gh-pages branch. The example files are set so that when you compile the example in R-studio, the output automatically goes into the _site folder. As a result, when you have these files in a github repository, github will encrypt and serve the html files in from the gh-pages branch as a website.

**Repo Settings**

1. Click the Settings (also near top right), scroll down to Github Pages options
2. Change the source to Github Actions
3. Go to Actions underneath secrets and variables
4. Create a new repository secret WEBSITE_TOKEN. The value will be your website password


**Editing webpage and serving on github**

1. download [github desktop](https://desktop.github.com)
2. make sure it is connected to your account
3. clone the website repo to your local computer
4. Open up the project file in the folder for your repo on your local computer (.rproj file)
5. Edit the .qmd files in R-studio
6. Recompile website (render website when index.qmd is loaded), or knit individual .qmd files
7. Send your changes back to the online github repository (note this can be done in github desktop, or directly in R-studio, in R-studio you will see a git tab if you are working in a git repo. Click the git tab, click the diff button, which will show you if there are any new changes. Click each of the files that you want to commit. Write a short note to describe the changes. Press the commit button. Press the push button. Wait a couple seconds, your changes should now be served on your website).

