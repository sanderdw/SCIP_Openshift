FROM debian:stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
USER appuser
RUN mkdir /home/appuser/
WORKDIR /home/appuser/

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b
RUN rm Miniconda3-latest-Linux-x86_64.sh

# Set path to conda
#ENV PATH /root/anaconda3/bin:$PATH
ENV PATH /home/appuser/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all

# Configuring access to Jupyter
RUN mkdir /home/appuser/notebooks
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /home/appuser/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888
EXPOSE 8888
# Run Jupytewr notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/home/appuser/notebooks", "--ip='*'", "--port=8888", "--no-browser"]

