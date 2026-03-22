# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully. There are no build errors present in the solution. Below are steps to validate, test, and deploy your migrated project.

## 1. Restore Dependencies

Run the following command in the root of your solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings about deprecated or incompatible packages. If any packages could not be resolved, check their availability on [NuGet.org](https://www.nuget.org) and update version numbers in your `.csproj` file accordingly.

## 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types, deprecated APIs, or platform compatibility.

## 3. Review Migrated Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and verify the following:

- The `<TargetFramework>` is set to the intended version, for example `net8.0` or `net6.0`.
- Any previously used packages that were specific to .NET Framework (e.g., `System.Web`, `EntityFramework` older versions) have been replaced with their cross-platform equivalents (e.g., `Microsoft.EntityFrameworkCore`).
- No `<HintPath>` references point to local DLLs that may not exist in the new environment.

## 4. Run Unit Tests

If the solution contains test projects, execute them with:

```bash
dotnet test
```

Review the test results carefully. Failing tests may indicate behavioral differences between .NET Framework and modern .NET that need to be addressed in the application logic.

## 5. Verify Application Configuration

- Confirm that `Web.config` has been replaced or supplemented by `appsettings.json` where applicable.
- Check that connection strings, application settings, and environment-specific configurations are correctly defined and accessible via `IConfiguration`.
- If the project uses ASP.NET Core, verify that `Program.cs` and `Startup.cs` (or the combined `Program.cs` in .NET 6+) are correctly configured.

## 6. Test Application Functionality Manually

Run the application locally:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Manually navigate through the application and verify:

- All pages or endpoints load without errors.
- Database connectivity is functioning as expected.
- Authentication and authorization flows work correctly.
- Any file I/O, email, or third-party integrations behave as expected.

## 7. Check for Platform-Specific API Usage

Use the .NET Upgrade Assistant or the compatibility analyzer to identify any remaining usage of Windows-only APIs if cross-platform deployment is intended:

```bash
dotnet add package Microsoft.DotNet.ApiCompat
```

Alternatively, review the code manually for any usage of APIs under `Microsoft.Win32`, `System.Drawing` (without the `System.Drawing.Common` package), or other Windows-specific namespaces.

## 8. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory to confirm all necessary files are present before deploying to your target environment.