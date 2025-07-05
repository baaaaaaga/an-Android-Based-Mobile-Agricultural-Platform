import http from '@/utils/http2';

export const uploadFileApi = (
  url = '/user/upload',
  file,
  name = 'file',
  formData = {},
  getTask = () => {}
) => {
  return http.request({
    url: url,
    method: 'UPLOAD',
    custom: {
      isLoading: true,
    },
    file,
    name,
    formData,
    getTask,
  });
};

export const uploadFilePathApi = (
  url = '/user/upload',
  filePath,
  name = 'file',
  formData = {},
  getTask = () => {}
) => {
  return http.request({
    url: url,
    method: 'UPLOAD',
    custom: {
      isLoading: true,
    },
    filePath,
    name,
    formData,
    getTask,
  });
};
