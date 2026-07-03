# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas of the code that may behave differently under modern .NET.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, such as `net8.0`. If it is targeting an older version like `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify runtime behavior:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise its core functionality to check for any runtime exceptions that would not have been caught at compile time.

### 5. Execute Existing Tests

If the solution contains any test projects, run them to validate that existing behavior has been preserved:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as failures may indicate behavioral differences between the legacy .NET Framework runtime and modern .NET.

### 6. Check for Windows-Specific APIs

Even with a successful build, the application may use APIs that only function correctly on Windows. Review the code for usages such as:

- `System.Web` types that were shimmed during transformation
- Windows Registry access
- Windows-specific file path assumptions (e.g., backslash separators)
- `HttpContext` or `Session` patterns that differ in ASP.NET Core

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` package to identify remaining platform-specific concerns.

### 7. Review Configuration Files

Ensure that any settings previously held in `Web.config` or `App.config` have been correctly migrated to `appsettings.json` and are being read via `IConfiguration`. Verify connection strings, app settings, and any custom configuration sections are present and correctly structured.

### 8. Test on Target Platform

If cross-platform support is a goal, run the application on the intended non-Windows platform (Linux or macOS) to surface any remaining platform-specific issues that local Windows testing would not reveal.

## Deployment

### 1. Publish the Application

Use the `dotnet publish` command to produce deployment artifacts:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj --configuration Release --output ./publish
```

### 2. Verify Published Output

Inspect the `./publish` directory to confirm all expected files are present, including static assets, configuration files, and the compiled binaries.

### 3. Configure the Web Server

Deploy the published output to the target web server. For IIS, install the [ASP.NET Core Hosting Bundle](https://learn.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/) and configure the site to use the `InProcess` or `OutOfProcess` hosting model as appropriate. For other environments such as Nginx or Apache, configure a reverse proxy pointing to the Kestrel process.