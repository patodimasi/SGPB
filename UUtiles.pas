unit UUtiles;

interface
uses
  SysUtils, shlobj, ActiveX, Windows, Forms, StdCtrls;

function EsFechaValida(DiaTxt, MesTxt, AnioTxt: string): Boolean;
function EsNumero(N: string): Boolean;
function BrowseForFolder(Title: string; RootCSIDL: integer = 0;
                         InitialFolder: string = ''): string; overload;
function BrowseForFolder(Title: string; RootFolder: WideString = '';
                         InitialFolder: string = ''): string; overload;

function InformarDatoInvalido(E: TEdit; sMsg: string): Boolean;

implementation
uses
  Graphics, Dialogs;

function EsFechaValida(DiaTxt, MesTxt, AnioTxt: string): Boolean;
var
  CodRet: Boolean;
  Dia, Mes, Anio: Integer;

begin
  CodRet:= True;
  try
    Dia:= StrToInt(DiaTxt);
    Mes:= StrToInt(MesTxt);
    Anio:= StrToInt(AnioTxt);

    if (Mes < 1) or (Mes > 12) or (Dia < 1) or (Dia > 31) or (Anio < 1999) or (Anio > 2019) then
      CodRet:= False
    else
    begin
      if (Dia = 31) and
         ((Mes = 1) or (Mes = 3) or (Mes = 5) or (Mes = 7) or (Mes = 8) or (Mes = 10) or (Mes = 12)) then
         CodRet:= False
      else if (Mes = 2) and (Dia > 28) then
      begin
        if (Dia = 29) and (Anio mod 4 = 0) and (Anio mod 100 <> 0) then
          CodRet:= True
        else
          CodRet:= False;
      end;
    end;
    Result:= CodRet;
  except
    Result:= False;
  end;
end;


function EsNumero(N: string): Boolean;
begin
  try
    StrToInt64(N);
    Result:= True;
  except
    Result:= False;
  end;
end;

function BrowseCallbackProc(Wnd: HWND; uMsg: UINT;
  lParam, lpData: LPARAM): Integer stdcall;
var
  Buffer: array [0..MAX_PATH-1] of char;
begin
  case uMsg of
  BFFM_INITIALIZED:
    if lpData <> 0 then
      SendMessage(Wnd, BFFM_SETSELECTION, 1, lpData);
  BFFM_SELCHANGED:
    begin
      SHGetPathFromIDList(PItemIDList(lParam), Buffer);
      SendMessage(Wnd, BFFM_SETSTATUSTEXT, 0, Integer(@Buffer));
    end;
  end;
  Result := 0;
end;


procedure IMallocFree(Ptr: Pointer);
var
  pMalloc: IMalloc;
begin
  if Succeeded(SHGetMalloc(pMalloc)) then
    pMalloc.Free(Ptr);
end;



function BrowseForFolder(Title: string; RootCSIDL: integer = 0;
  InitialFolder: string = ''): string; overload;
var
  BrowseInfo: TBrowseInfo;
  Buffer: array [0..MAX_PATH-1] of char;
  ResultPItemIDList: PItemIDList;
begin
  with BrowseInfo do begin
    hwndOwner := Application.Handle;
    if RootCSIDL = 0 then
      pidlRoot := nil
    else
      SHGetSpecialFolderLocation(hwndOwner, RootCSIDL,
        pidlRoot);
    pszDisplayName := @Buffer;
    lpszTitle := PChar(Title);
    ulFlags := BIF_RETURNONLYFSDIRS or BIF_STATUSTEXT;
    lpfn := BrowseCallbackProc;
    lParam := Integer(Pointer(InitialFolder));
    iImage := 0;
  end;

  Result := '';
  ResultPItemIDList := SHBrowseForFolder(BrowseInfo);
  if ResultPItemIDList <> nil then begin
    SHGetPathFromIDList(ResultPItemIDList, Buffer);
    Result := Buffer;
    IMallocFree(ResultPItemIDList);
  end;
  with BrowseInfo do if pidlRoot <> nil then IMallocFree(pidlRoot);
end;

function BrowseForFolder(Title: string; RootFolder: WideString = '';
  InitialFolder: string = ''): string; overload;
var
  BrowseInfo: TBrowseInfo;
  Buffer: array [0..MAX_PATH-1] of char;
  ResultPItemIDList: PItemIDList;
  IDesktopFolder: IShellFolder;
  Eaten, Attributes: LongWord;
begin
  with BrowseInfo do begin
    hwndOwner := Application.Handle;
    pidlRoot := nil;
    if RootFolder <> '' then begin
      SHGetDesktopFolder(IDesktopFolder);
      IDesktopFolder.ParseDisplayName(Application.Handle, nil,
        PWideChar(RootFolder), Eaten, pidlRoot, Attributes);
    end;
    pszDisplayName := @Buffer;
    lpszTitle := PChar(Title);
    ulFlags := BIF_RETURNONLYFSDIRS or BIF_STATUSTEXT;
    lpfn := BrowseCallbackProc;
    lParam := Integer(Pointer(InitialFolder));
    iImage := 0;
  end;
  Result := '';
  ResultPItemIDList := SHBrowseForFolder(BrowseInfo);
  if ResultPItemIDList <> nil then begin
    SHGetPathFromIDList(ResultPItemIDList, Buffer);
    Result := Buffer;
    IMallocFree(ResultPItemIDList);
  end;
  with BrowseInfo do if pidlRoot <> nil then IMallocFree(pidlRoot);
end;

function InformarDatoInvalido(E: TEdit; sMsg: string): Boolean;
begin
  E.Color:= clYellow;
  ShowMessage(sMsg);
  E.Color:= clWindow;
  E.SetFocus;
  Result:= False;
end;

end.
